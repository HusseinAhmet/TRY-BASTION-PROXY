pipeline {
    agent {label 'ec2'}
tools {
  terraform 'terraform'
}
    
stages {

        stage('Create Infrastructure') {
            steps {
       
                
                 sh '''
                    cd Terraform/
                    terraform init 
                    terraform apply -var-file var.tfvars -auto-approve
                    ansible localhost -m lineinfile -a "path="${WORKSPACE}"/ssh-config  regexp='..b ' line='    b $(terraform output -raw jumpbox-pubIP)' "
                    ansible localhost -m lineinfile -a "path="${WORKSPACE}"/ssh-config  regexp='..s1 ' line='    s1 $(aws ec2 describe-instances --region eu-west-3 --filters "Name=tag:Name,Values= try-bastiioin - Server1" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)' "                
                    ansible localhost -m lineinfile -a "path="${WORKSPACE}"/ssh-config  regexp='..s2 ' line='    s2 $(aws ec2 describe-instances --region eu-west-3 --filters "Name=tag:Name,Values= try-bastiioin - Server2" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)' "
                    '''
            }
         post {             
                 success {
                      slackSend color: 'good', message: 'Create Infrastructure success '
                }
                failure {
                      slackSend color: 'bad', message: 'Create Infrastructure failure '
                    sh """
                      cd Terraform/ 
                      terraform destroy -var-file var.tfvars -auto-approve
                      """
                }
                
            }
        }
        stage('Configure Servers & Deploy ') {
            steps {
       
                
                 sh """

                    ansible-playbook priv-server.yml -i inventory.txt --private-key /home/ubuntu/train-key.pem 
                """
                

            }
         post {             
                 success {
                      slackSend color: 'good', message: 'Deploy success '
                }
                failure {
                      slackSend color: 'bad', message: 'Deploy failure '
                    //   sh """
                    //   cd Terraform/ 
                    //   terraform destroy -var-file var.tfvars -auto-approve
                    //   """
                      
                }
                
            }
        }

    }


// stages {

//         stage('Destroy Infrastructure') {
//             steps {
       
//                   sh """
//                       cd Terraform/ 
//                       terraform destroy -var-file var.tfvars -auto-approve
//                       """
                

//             }

//         }
       

//     }

}



    