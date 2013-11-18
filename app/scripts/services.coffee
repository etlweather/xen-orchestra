angular.module('xoWebApp')

  # This service provides session management and inject the `user`
  # into the `$rootScope`.
  .service 'session', ($rootScope) ->
    {
      logIn: (email, password) ->
        $rootScope.user = {
          email: email
        }

      logOut: ->
        $rootScope.user = null
    }

  # This service provides access to XO objects.
  .service 'objects', ->
    giga = Math.pow 1024, 3

    objects = {

      # Pools.
      '843c4b17-7ecf-4102-8696-e0da715e3791': {
        type: 'pool'
        name_label: 'Main pool'
        name_description: 'Lorem Ipsum Cloud Dolor'
        tags: ['Prod', 'Room1']
        default_SR: 'a86fbb1e-55dd-428e-8154-8bb4f46846d9'
        HA_enabled: true
        hosts: [
          'b52ebcdb-72e0-45f6-8ec8-2c84ca24d0ec'
        ]
        master: 'b52ebcdb-72e0-45f6-8ec8-2c84ca24d0ec'
      }
      '2d10b0a0-eca4-43a1-8ffb-6266c73280b1': {
        type: 'pool'
        name_label: 'Dev pool'
        name_description: 'Dev pool for dev VMs'
        tags: ['Dev', 'Lab']
        #default_SR: null
        HA_enabled: false
        hosts: [
          'ae1a5bac-ac38-4577-bd75-251628549558'
        ]
        master: 'ae1a5bac-ac38-4577-bd75-251628549558'
      }

      # Hosts
      'b52ebcdb-72e0-45f6-8ec8-2c84ca24d0ec': {
        type: 'host'
        name_label: 'Host1'
        name_description: 'Prod Host'
        tags: ['Prod']
        address: '192.168.1.1'
        CPUs: [
          {}
          {}
        ]
        enabled: true
        hostname: 'Host1'
        memory: {
          size: 16 * giga # in bytes
          usage: 4 * giga # in bytes
        }
        power_state: 'Running'
        SRs: [
          'ba305307-db94-4f1b-b9fb-dbbbd269cd3d'
          'a86fbb1e-55dd-428e-8154-8bb4f46846d9'
        ]
        VMs: [
          '24069f43-0eb1-494a-9911-3b3b371d8b74'
          'f6c55ab5-e74e-470f-b928-a2559fcf7f56'
          'e37e7597-10d7-4bfe-af63-256be1c0a1d1'
        ]
      }
      'ae1a5bac-ac38-4577-bd75-251628549558': {
        type: 'host'
        name_label: 'Dev1'
        name_description: 'Dev Host for IT'
        tags: ['Dev']
        address: '192.168.1.103'
        CPUs: [
          {}
          {}
        ]
        enabled: false
        hostname: 'Dev1'
        memory: {
          size: 16 * giga # in bytes
          usage: 4 * giga # in bytes
        }
        power_state: 'Running'
        SRs: [
          '81e31c8f-9d84-4fa5-b5ff-174e36cc366f'
          'e629bc99-ecfe-4c88-b6e8-ee6e33d12f04'
        ]
        #VMs: []
      }

      # VMs
      '24069f43-0eb1-494a-9911-3b3b371d8b74': {
        type: 'VM'
        name_label: 'VM1'
        name_description: 'Default VM for tests'
        tags: ['Web', 'Test', 'Debian']
        address: '192.168.1.42'
        memory: {
          size: 2 * giga # in bytes
          # usage: undefined # in bytes
        }
        power_state: 'Running'
        CPUs: [
          {
            usage: 50 # in percentage
          }
        ]
      }
      'f6c55ab5-e74e-470f-b928-a2559fcf7f56': {
        type: 'VM'
        name_label: 'VM Dev 2'
        name_description: 'Default VM'
        #tags: []
        address: ''
        memory: {
          size: 2 * giga # in bytes
          # usage: undefined # in bytes
        }
        power_state: 'Halted'
        CPUs: []
      }
      'e37e7597-10d7-4bfe-af63-256be1c0a1d1': {
        type: 'VM'
        name_label: 'VFirewall'
        name_description: 'Created from template'
        #tags: []
        address: '192.168.1.12'
        memory: {
          size: 4 * giga # in bytes
          # usage: undefined # in bytes
        }
        power_state: 'Running'
        CPUs: [
          {
            usage: 64 # in percentage
          }
          {
            usage: 99 # in percentage
          }
        ]
      }

      # SRs
      '81e31c8f-9d84-4fa5-b5ff-174e36cc366f': {
        type: 'SR'
        name_label: 'ZFS1'
        name_description: 'Nexenta SAN Storage iSCSI'
        tags: ['SAN', 'ZFS', 'Nexenta', 'Prod', 'SR']
        physical_usage: 5 * giga # in bytes
        shared: true
        size: 100 * giga # in bytes
        SR_type: 'LVM'
        usage: 10 * giga # in bytes
      }
      'ba305307-db94-4f1b-b9fb-dbbbd269cd3d': {
        type: 'SR'
        name_label: 'Local Storage'
        name_description: 'Local Disk'
        tags: ['Local', 'SR']
        physical_usage: 5 * giga # in bytes
        shared: false
        size: 100 * giga # in bytes
        SR_type: 'LVM'
        usage: 10 * giga # in bytes
      }
      'a86fbb1e-55dd-428e-8154-8bb4f46846d9': {
        type: 'SR'
        name_label: 'ISO SR'
        name_description: 'ISO repository'
        tags: ['Local', 'SR']
        physical_usage: 2 * giga # in bytes
        shared: true
        size: 100 * giga # in bytes
        SR_type: 'ISO'
        usage: 10 * giga # in bytes
      }
      'e629bc99-ecfe-4c88-b6e8-ee6e33d12f04': {
        type: 'SR'
        name_label: 'Local Storage'
        name_description: 'Local Disk'
        tags: ['Local', 'SR']
        physical_usage: 5 * giga # in bytes
        shared: false
        size: 100 * giga # in bytes
        SR_type: 'LVM'
        usage: 10 * giga # in bytes
      }
    }

    # Injects the UUID in the objects.
    object.$UUID = UUID for UUID, object of objects

    # Creates a view with objects grouped by type.
    byTypes = {}
    for _, object of objects
      {type} = object
      (byTypes[type] ?= []).push object

    # Creates reflexive links & compute additional statistics.
    for VM in byTypes.VM ? []
      if VM.CPUs?.length
        CPU_usage = 0
        for CPU in VM.CPUs ? []
          CPU_usage += CPU.usage
        VM.$CPU_usage = CPU_usage / VM.CPUs.length

    for host in byTypes.host ? []
      running_VMs = []
      vCPUs = []
      for VM_UUID in host.VMs ? []
        VM = objects[VM_UUID]

        VM.$host = host.$UUID
        if 'Running' == VM.power_state
          running_VMs.push VM
          vCPUs.push VM.CPUs...
      host.$running_VMs = running_VMs
      host.$vCPUs = vCPUs

      local_SRs = []
      shared_SRs = []
      for SR_UUID in host.SRs ? []
        SR = objects[SR_UUID]

        SR.$host = host.$UUID
        if SR.shared
          shared_SRs.push SR_UUID
        else
          local_SRs.push SR_UUID
      host.$local_SRs = local_SRs
      host.$shared_SRs = shared_SRs

    for pool in byTypes.pool ? []
      running_hosts = []
      running_VMs = []
      SRs = []
      VMs = []
      for host_UUID in pool.hosts ? []
        host = objects[host_UUID]

        host.$pool = pool.$UUID
        running_hosts.push host if 'Running' == host.power_state
        running_VMs.push host.$running_VMs...
        SRs.push host.$shared_SRs...
        VMs.push host.VMs...
      pool.$running_hosts = running_hosts
      pool.$running_VMs = running_VMs
      pool.$SRs = SRs
      pool.$VMs = VMs

    {
      all: object for _, object of objects
      byUUIDs: objects
      byTypes: byTypes
    }

  .service 'stats', ->

    {
      stats: {
        pools: 2
        hosts: 4
        VMs: 6
        running_VMs: 5
        vCPUs: 32
        CPUs: 12
        memory: {
          usage: 32 * Math.pow(1024, 3)
          size: 64 * Math.pow(1024, 3)
        }
      }
    }
