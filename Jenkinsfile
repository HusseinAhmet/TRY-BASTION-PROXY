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
                    ansible localhost -m lineinfile -a "path="${WORKSPACE}"/ssh-config  regexp='^.*b1 ' line='  HostName $(terraform output -raw jumpbox-pubIP)' "
                    ansible localhost -m lineinfile -a "path="${WORKSPACE}"/ssh-config  regexp='^.*s1 ' line='  HostName $(aws ec2 describe-instances --region eu-west-3 --filters "Name=tag:Name,Values=' try-bastiioin - Server1'" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)' "                
                    ansible localhost -m lineinfile -a "path="${WORKSPACE}"/ssh-config  regexp='^.*s2 ' line='  HostName $(aws ec2 describe-instances --region eu-west-3 --filters "Name=tag:Name,Values=' try-bastiioin - Server2'" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)' "
                    cp "${WORKSPACE}"/ssh-config /home/ubuntu/.ssh/config
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



    