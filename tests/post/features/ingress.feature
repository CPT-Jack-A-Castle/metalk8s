@post @ci @local @ingress
Feature: Ingress
    Scenario: Access HTTP services
        Given the Kubernetes API is available
        And pods with label 'app.kubernetes.io/name=ingress-nginx' are 'Ready'
        When we perform an HTTP request on port 80 on a workload-plane IP
        Then the server returns 404 'Not Found'

    Scenario: Access HTTPS services
        Given the Kubernetes API is available
        And pods with label 'app.kubernetes.io/name=ingress-nginx' are 'Ready'
        When we perform an HTTPS request on port 443 on a workload-plane IP
        Then the server returns 404 'Not Found'

    Scenario: Access HTTP services on control-plane IP
        Given the Kubernetes API is available
        And pods with label 'app.kubernetes.io/name=ingress-nginx' are 'Ready'
        And the node control-plane IP is not equal to its workload-plane IP
        When we perform an HTTP request on port 80 on a control-plane IP
        Then the server should not respond
