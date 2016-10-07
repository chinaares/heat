# heat
basic heat examples

##- first.yaml

Creates a network


##- Second.yaml

Creates an instance on the private network, this network should be already created


##- Third.yaml

demostratrs how to execute scrips inside the deployed image using os-collect-config. It also demostrates how to create a glance image with the required software



```
# heat stack-list

heat stack-show <stack>
...
...

outputs               | [                                                                                                                          |
|                       |   {                                                                                                                        |
|                       |     "output_value": null,                                                                                                  |
|                       |     "description": "The IP assigned to me",                                                                                |
|                       |     "output_key": "my_ip0"                                                                                                 |
|                       |   },                                                                                                                       |
|                       |   {                                                                                                                        |
|                       |     "output_value": "11.0.0.4",                                                                                            |
|                       |     "description": "The IP assigned to me",                                                                                |
|                       |     "output_key": "my_ip1"                                                                                                 |
|                       |   },                                                                                                                       |
|                       |   {                                                                                                                        |
|                       |     "output_value": {                                                                                                      |
|                       |       "internal02": [                                                                                                      |
|                       |         "11.0.0.4"                                                                                                         |
|                       |       ],                                                                                                                   |
|                       |       "private": [                                                                                                         |
|                       |         "10.10.1.107",                                                                                                     |
|                       |         "192.168.101.101"                                                                                                  |
|                       |       ]                                                                                                                    |
|                       |     },                                                                                                                     |
|                       |     "description": "all network information",                                                                              |
|                       |     "output_key": "netinfo"                                                                                                |
|                       |   }                                                                                                                        |
|                       | ]                   
...
...

# heat resource-list sconfig
+---------------+--------------------------------------+--------------------------+-----------------+----------------------+
| resource_name | physical_resource_id                 | resource_type            | resource_status | updated_time         |
+---------------+--------------------------------------+--------------------------+-----------------+----------------------+
| boot_script   | d9f784af-31cb-487d-a788-f1ee39fe9d8f | OS::Heat::SoftwareConfig | CREATE_COMPLETE | 2016-09-27T14:39:58Z |
| my_instance   | e7c5a641-79d9-47cb-b2a8-11daf9d684ce | OS::Nova::Server         | CREATE_COMPLETE | 2016-09-27T14:39:58Z |
+---------------+--------------------------------------+--------------------------+-----------------+----------------------+


# heat resource-show sconfig boot_script
+------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+
| Property               | Value                                                                                                                                            |
+------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------+
| attributes             | {                                                                                                                                                |
|                        |   "config": "#!/bin/bash\necho \"Running boot script\" > /executed.txt\n"                                                                        |
|                        | }                                                                                                                                                |
| description            |                                                                                                                                                  |
| links                  | http://192.168.101.199:8004/v1/b7465b684f7c48958eca3f1aa117dbba/stacks/sconfig/a0fcdaf2-d9e9-4b12-8db2-b217ed261c0d/resources/boot_script (self) |
|                        | http://192.168.101.199:8004/v1/b7465b684f7c48958eca3f1aa117dbba/stacks/sconfig/a0fcdaf2-d9e9-4b12-8db2-b217ed261c0d (stack)                      |
| logical_resource_id    | boot_script                                                                                                                                      |
| physical_resource_id   | d9f784af-31cb-487d-a788-f1ee39fe9d8f                                                                                                             |
| required_by            | my_instance                                                                                                                                      |
| resource_name          | boot_script                                                                                                                                      |
| resource_status        | CREATE_COMPLETE                                                                                                                                  |
| resource_status_reason | state changed                                                                                                                                    |
| resource_type          | OS::Heat::SoftwareConfig                                                                                                                         |
| updated_time           | 2016-09-27T14:39:58Z                                                                                                                             |
```


```

# heat output-show sconfig --all
[
  {
    "output_value": null, 
    "description": "The IP assigned to me", 
    "output_key": "my_ip0"
  }, 
  {
    "output_value": "11.0.0.4", 
    "description": "The IP assigned to me", 
    "output_key": "my_ip1"
  }, 
  {
    "output_value": {
      "internal02": [
        "11.0.0.4"
      ], 
      "private": [
        "10.10.1.107", 
        "192.168.101.101"
      ]
    }, 
    "description": "all network information", 
    "output_key": "netinfo"
  }
]
```

```

# heat event-list sconfig
+---------------+--------------------------------------+-------------------------------------+--------------------+----------------------+
| resource_name | id                                   | resource_status_reason              | resource_status    | event_time           |
+---------------+--------------------------------------+-------------------------------------+--------------------+----------------------+
| sconfig       | cb342328-d722-43be-924d-6079bda65a45 | Stack CREATE started                | CREATE_IN_PROGRESS | 2016-09-27T14:39:58Z |
| boot_script   | 0aa36ff2-00a2-4834-9233-9fb99cbf887c | state changed                       | CREATE_IN_PROGRESS | 2016-09-27T14:39:58Z |
| boot_script   | 2866d532-cf11-4ef1-9db9-f9607d91be03 | state changed                       | CREATE_COMPLETE    | 2016-09-27T14:39:58Z |
| my_instance   | 233d420a-cd5e-4594-98b7-53615b60169d | state changed                       | CREATE_IN_PROGRESS | 2016-09-27T14:39:58Z |
| my_instance   | 4d4ff4ac-32f4-453d-9b38-4bfe76608b53 | state changed                       | CREATE_COMPLETE    | 2016-09-27T14:40:18Z |
| sconfig       | 2cbf3e90-1bed-40fb-88c5-2b2587affa03 | Stack CREATE completed successfully | CREATE_COMPLETE    | 2016-09-27T14:40:18Z |
+---------------+--------------------------------------+-------------------------------------+--------------------+----------------------+
```

```

# heat resorce-show boot_acript  doesnt work because it is not a software deployment, its a software congig

]# grep admin_tok /etc/keystone/keystone.conf
#admin_token = ADMIN
admin_token = c3c42fc52fe4439ca0e705ea150005e6
```


    An OS::Heat::SoftwareConfig resource - this encapsulates the config to be applied, e.g a script, puppet manifest, or any other config definition format you care to use.  This is just a wrapper for the config to apply, optionally parameterized with input values, it doesn't actually configure anything.
    
An OS::Heat::SoftwareDeployment resource - this is the thing which actually applies the config from (1) - when it moves to and IN_PROGRESS state, it makes the config available to the specified server.  By default, the deployment will stay in the IN_PROGRESS state until a signal is received via the Heat API, notifying the service of success (or failure..) applying the config.
  
  An OS::Nova::Server resource - this is the instance (or physical server in the case of TripleO deploying via Nova and Ironic) being configured, it must contain some tools to support SoftwareConfig, as discussed below, and define the user_data_format property to enable SoftwareConfig.


##- Forth.yaml

Dermodtrates how execute scripts inside the deployed instance usiung cloud-init

as you cansee, the script is not a resource, its a parameter
```

# heat resource-list a


+---------------+--------------------------------------+------------------+-----------------+----------------------+
| resource_name | physical_resource_id                 | resource_type    | resource_status | updated_time         |
+---------------+--------------------------------------+------------------+-----------------+----------------------+
| my_instance   | f78b5ba2-a3e6-4be7-9bc3-b570f09d19f6 | OS::Nova::Server | CREATE_COMPLETE | 2016-10-06T12:32:58Z |
+---------------+--------------------------------------+------------------+-----------------+----------------------+
```

```

]# heat stack-show a


+-----------------------+----------------------------------------------------------------------------------------------------------------------+
| Property              | Value                                                                                                                |
+-----------------------+----------------------------------------------------------------------------------------------------------------------+
| capabilities          | []                                                                                                                   |
| creation_time         | 2016-10-06T12:32:57Z                                                                                                 |
| description           | Simple template to deploy a single compute instance                                                                  |
| disable_rollback      | True                                                                                                                 |
| id                    | 34566ab6-188b-4bb6-9c34-e3fcb7c6efb1                                                                                 |
| links                 | http://192.168.101.199:8004/v1/b7465b684f7c48958eca3f1aa117dbba/stacks/a/34566ab6-188b-4bb6-9c34-e3fcb7c6efb1 (self) |
| notification_topics   | []                                                                                                                   |
| outputs               | [                                                                                                                    |
|                       |   {                                                                                                                  |
|                       |     "output_value": null,                                                                                            |
|                       |     "description": "The IP assigned to me",                                                                          |
|                       |     "output_key": "my_ip0"                                                                                           |
|                       |   },                                                                                                                 |
|                       |   {                                                                                                                  |
|                       |     "output_value": "11.0.0.6",                                                                                      |
|                       |     "description": "The IP assigned to me",                                                                          |
|                       |     "output_key": "my_ip1"                                                                                           |
|                       |   },                                                                                                                 |
|                       |   {                                                                                                                  |
|                       |     "output_value": {                                                                                                |
|                       |       "internal02": [                                                                                                |
|                       |         "11.0.0.6"                                                                                                   |
|                       |       ],                                                                                                             |
|                       |       "private": [                                                                                                   |
|                       |         "10.10.1.109",                                                                                               |
|                       |         "192.168.101.101"                                                                                            |
|                       |       ]                                                                                                              |
|                       |     },                                                                                                               |
|                       |     "description": "all network information",                                                                        |
|                       |     "output_key": "netinfo"                                                                                          |
|                       |   }                                                                                                                  |
|                       | ]                                                                                                                    |
| parameters            | {                                                                                                                    |
|                       |   "OS::project_id": "b7465b684f7c48958eca3f1aa117dbba",                                                              |
|                       |   "OS::stack_id": "34566ab6-188b-4bb6-9c34-e3fcb7c6efb1",                                                            |
|                       |   "OS::stack_name": "a",                                                                                             |
|                       |   "image": "e65b6e98-b95d-4d19-8e8f-0677690951fd",                                                                   |
|                       |   "key": "hypervisor",                                                                                               |
|                       |   "flavor": "2",                                                                                                     |
|                       |   "foo": "these is the strin to pass  ooo"                                                                           |
|                       | }                                                                                                                    |
| parent                | None                                                                                                                 |
| stack_name            | a                                                                                                                    |
| stack_owner           | admin                                                                                                                |
| stack_status          | CREATE_COMPLETE                                                                                                      |
| stack_status_reason   | Stack CREATE completed successfully                                                                                  |
| stack_user_project_id | af518e6c723a46ffa5b2dea3e1a3f548                                                                                     |
| template_description  | Simple template to deploy a single compute instance                                                                  |
| timeout_mins          | 60                                                                                                                   |
| updated_time          | None                                                                                                                 |
+-----------------------+----------------------------------------------------------------------------------------------------------------------+
```



