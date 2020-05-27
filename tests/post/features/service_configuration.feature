@post @local @ci @csc
Feature: Cluster and Services Configurations
    Scenario: Propagation of Service Configurations to underlying Services
        Given the Kubernetes API is available
        And pods with label 'app.kubernetes.io/name=dex' are 'Ready'
        And we have 2 running pod labeled 'app.kubernetes.io/name=dex' in namespace 'metalk8s-auth'
        And we have a 'metalk8s-dex-config' CSC in namespace 'metalk8s-auth'
        When we update the CSC 'spec.deployment.replicas' to '3'
        Then we have '3' at 'status.available_replicas' for 'dex' Deployment in namespace 'metalk8s-auth'

    Scenario: Update Admin static user password
        Given the Kubernetes API is available
        And we have a 'metalk8s-dex-config' CSC in namespace 'metalk8s-auth'
        # NOTE: Consider that admin user is the first of the userlist
        # Update password to "new-password"
        When we update the CSC 'spec.localuserstore.userlist.0.hash' to '$2y$14$pDe0vj917rR3XJQ5iEZvhuSGoWkZg2/qBN/mMLqwFSz9S7EYcbIpO'
        Then we have 2 running pod labeled 'app.kubernetes.io/name=dex' in namespace 'metalk8s-auth'
        And we are not able to login to Dex as 'admin@metalk8s.invalid' using password 'password'
        And we are able to login to Dex as 'admin@metalk8s.invalid' using password 'new-password'

    Scenario: Customization of pre-defined Prometheus rules
        Given the Kubernetes API is available
        And pods with label 'app=prometheus' are 'Ready'
        And we have a 'metalk8s-prometheus-config' CSC in namespace 'metalk8s-monitoring'
        When we update the CSC 'spec.rules.node_exporter.node_filesystem_space_filling_up.warning.hours' to '48'
        Then we have an alert rule 'NodeFilesystemSpaceFillingUp' in group 'node-exporter' with severity 'warning' and 'annotations.summary' equal to 'Filesystem is predicted to run out of space within the next 48 hours.'
