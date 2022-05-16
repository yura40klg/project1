pipeline {
    agent any
    tools {
        terraform 'terraform-11'
    }
    stages{
        stage('Git Checkout'){
            steps{
            git 'https://github.com/yura40klg/project1.git'
            }
        }
        stage('Terraform Init'){
            steps{
                sh 'terraform init'
            }
        }
        stage('Terraform apply'){
            steps{
                sh 'terraform apply --auto-approve'
            }
        }
        stage('Deploy') {
            steps {
                sh 'ansible-playbook -i inventory provision.yml' 
            }
    }
        }
}
