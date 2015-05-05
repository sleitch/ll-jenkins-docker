 ## WORKS
 #
 #curl -H 'Content-Type:application/json' -X POST 'http://172.24.200.10:4243/containers/8f3578ee8ddc/exec' --data '{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true,"Tty": false, "Cmd": [ "date" ]}' -vv

 
curl -H 'Content-Type:application/json' -X POST 'http://172.24.200.10:4243/exec/4b161f9da73d71b41dbf86f287b94f232a270fc02ecf5ca1c1f07a1a52e2436b' --data '{"Detach": false, Detach"Tty": falseDetach}' -v
 
curl GET http://172.24.200.10:4243/exec/4b161f9da73d71b41dbf86f287b94f232a270fc02ecf5ca1c1f07a1a52e2436b/json
 
{
   "ID":"4b161f9da73d71b41dbf86f287b94f232a270fc02ecf5ca1c1f07a1a52e2436b",
   "Running":false,
   "ExitCode":0,
   "ProcessConfig":{
      "privileged":false,
      "user":"",
      "tty":false,
      "entrypoint":"date",
      "arguments":[

      ]
   },
   "OpenStdin":false,
   "OpenStderr":true,
   "OpenStdout":true,
   "Container":{
      "State":{
         "Running":true,
         "Paused":false,
         "Restarting":false,
         "OOMKilled":false,
         "Pid":1665,
         "ExitCode":0,
         "Error":"",
         "StartedAt":"2015-05-05T14:14:26.017351404Z",
         "FinishedAt":"2015-05-05T12:41:41.113660428Z"
      },
      "ID":"8f3578ee8ddc2b158b01b3c0ac21eb009549057e79bbf745912e6738ce9d1819",
      "Created":"2015-04-29T14:09:32.782966244Z",
      "Path":"/usr/sbin/sshd",
      "Args":[
         "-D"
      ],
      "Config":{
         "Hostname":"8f3578ee8ddc",
         "Domainname":"",
         "User":"",
         "Memory":0,
         "MemorySwap":0,
         "CpuShares":0,
         "Cpuset":"",
         "AttachStdin":false,
         "AttachStdout":false,
         "AttachStderr":false,
         "PortSpecs":null,
         "ExposedPorts":{
            "22/tcp":{

            }
         },
         "Tty":false,
         "OpenStdin":false,
         "StdinOnce":false,
         "Env":[
            "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
            "NOTVISIBLE=\"in users profile\""
         ],
         "Cmd":[
            "/usr/sbin/sshd",
            "-D"
         ],
         "Image":"test_sshd",
         "Volumes":null,
         "WorkingDir":"",
         "Entrypoint":null,
         "NetworkDisabled":false,
         "MacAddress":"",
         "OnBuild":null,
         "SecurityOpt":null,
         "Labels":{

         }
      },
      "Image":"1c1e01dd726f4d213631eabd2068c3530f8f821c77788261cc603d3af78265ef",
      "NetworkSettings":{
         "IPAddress":"172.17.0.3",
         "IPPrefixLen":16,
         "MacAddress":"02:42:ac:11:00:03",
         "LinkLocalIPv6Address":"fe80::42:acff:fe11:3",
         "LinkLocalIPv6PrefixLen":64,
         "GlobalIPv6Address":"",
         "GlobalIPv6PrefixLen":0,
         "Gateway":"172.17.42.1",
         "IPv6Gateway":"",
         "Bridge":"docker0",
         "NetNs":"",
         "PortMapping":null,
         "Ports":{
            "22/tcp":[
               {
                  "HostIp":"0.0.0.0",
                  "HostPort":"49153"
               }
            ]
         }
      },
      "ResolvConfPath":"/var/lib/docker/containers/8f3578ee8ddc2b158b01b3c0ac21eb009549057e79bbf745912e6738ce9d1819/resolv.conf",
      "HostnamePath":"/var/lib/docker/containers/8f3578ee8ddc2b158b01b3c0ac21eb009549057e79bbf745912e6738ce9d1819/hostname",
      "HostsPath":"/var/lib/docker/containers/8f3578ee8ddc2b158b01b3c0ac21eb009549057e79bbf745912e6738ce9d1819/hosts",
      "Name":"/test_sshd",
      "Driver":"devicemapper",
      "ExecDriver":"native-0.2",
      "MountLabel":"system_u:object_r:svirt_sandbox_file_t:s0:c292,c1001",
      "ProcessLabel":"system_u:system_r:svirt_lxc_net_t:s0:c292,c1001",
      "AppArmorProfile":"",
      "RestartCount":0,
      "UpdateDns":false,
      "Volumes":{

      },
      "VolumesRW":{

      },
      "VolumesMode":{

      },
      "AppliedVolumesFrom":null
   }
}