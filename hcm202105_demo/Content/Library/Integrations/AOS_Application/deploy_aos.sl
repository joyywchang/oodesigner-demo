namespace: Integrations.AOS_Application
flow:
  name: deploy_aos
  inputs:
    - target_host: 172.16.239.121
    - target_host_username: root
    - target_host_password:
        default: ' Cloud_1234'
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 246
        'y': 236.1875
      install_java:
        x: 464
        'y': 222
      install_tomcat:
        x: 618
        'y': 208
      install_aos_application:
        x: 748
        'y': 248
        navigate:
          5567c71a-8993-aad9-4c20-f9a7b269c519:
            targetId: 64f94143-cfe9-54ea-794c-50c75954f8b9
            port: SUCCESS
    results:
      SUCCESS:
        64f94143-cfe9-54ea-794c-50c75954f8b9:
          x: 928
          'y': 268
