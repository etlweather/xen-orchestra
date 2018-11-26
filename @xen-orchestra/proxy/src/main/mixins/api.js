import { format, parse, MethodNotFound } from 'json-rpc-protocol'
import { get } from 'lodash'
import createLogger from '@xen-orchestra/log'
import getStream from 'get-stream'
import helmet from 'koa-helmet'
import Koa from 'koa'
import Router from 'koa-router'
import Zone from 'node-zone'

const { debug, warn } = createLogger('xo:proxy:api')

export default class Api {
  constructor(app, { httpServer }) {
    this._app = app
    this._handler = { __proto__: null }
    this._methods = /* { __proto__: null } */ app

    const router = new Router({ prefix: '/api' })
      .get('/:token', async (ctx, next) => {
        try {
          const payload = await app.decodeJwt(ctx.params.token)
          console.log(payload)
          ctx.body = payload
        } catch (error) {
          return next()
        }
      })
      .post('/', async ctx => {
        let body
        try {
          body = parse(await getStream(ctx.req))
        } catch (error) {
          ctx.body = format.error(null, error)
          throw error
        }

        try {
          const result = await this._call(body.method, body.params)
          ctx.body = format.response(
            body.id,
            result !== undefined ? result : true
          )
        } catch (error) {
          ctx.body = format.error(body.id, error)
          throw error
        }
      })

    const koa = new Koa()
      .on('error', warn)
      .use(helmet())
      .use(router.routes())
      .use(router.allowedMethods())

    httpServer.on('request', koa.callback())
  }

  _call(method, params) {
    debug(`call: ${method}(${JSON.stringify(params)})`)
    const methods = this._methods
    const parts = method.split('.')
    const context = get(methods, parts.slice(0, -1))
    const fn = get(methods, method)
    if (fn === undefined) {
      throw new MethodNotFound(method)
    }

    const zone = Zone.current.fork(`api call: ${method}`)
    return zone.run(() =>
      Array.isArray(params)
        ? fn.apply(context, params)
        : fn.call(context, params)
    )
  }
}
