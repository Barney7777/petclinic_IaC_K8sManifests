pipeline {
    agent any
    environment {
        PACKER_FILE = "eks_node_ami.pkr.hcl"
    }

    stages {
        stage ('Checkout code') {
            steps {
                git branch: 'main', url: 'https://github.com/Barney7777/petclinic_IaC_K8sManifests.git'
            }
        }

        stage ('packer init') {
            steps {
                dir("Packer-AMI/AMI-EKS-node") {
                    script {
                        echo "Initializing Packer"
                        sh "packer init $PACKER_FILE"
                    }
                }
            }
        }

        stage ('packer fmt') {
            steps {
                dir("Packer-AMI/AMI-EKS-node") {
                    script {
                        echo "formatting Packer"
                        sh "packer fmt $PACKER_FILE"
                    }
                }
            }
        }

        stage ('packer validate') {
            steps {
                dir("Packer-AMI/AMI-EKS-node") {
                    script {
                        echo "validating Packer"
                        sh "packer validate $PACKER_FILE"
                    }
                }
            }
        }

        stage ('packer build ami') {
            steps {
                dir("Packer-AMI/AMI-EKS-node") {
                    script {
                        echo "Building Packer"
                        sh "packer build $PACKER_FILE"
                    }
                }
            }
        }
    }
}