pipeline {
    agent {label 'ec2'}
tools {
  terraform 'terraform'
}
    
stages {

        stage('Create Infrastructure') {
            steps {
       
                
                 sh '''
                    echo "[nodes]" > "${WORKSPACE}"/inventory.txt
                    cd Terraform/
                    terraform init 
                    terraform apply -var-file var.tfvars -auto-approve
                    echo "[nodes:vars] ">> "${WORKSPACE}"/inventory.txt 
                    echo "ansible_user=ubuntu ">> "${WORKSPACE}"/inventory.txt 
                    echo "ansible_port=22">> "${WORKSPACE}"/inventory.txt 
                    echo "ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand=\"ssh -p 22 -i /home/ubuntu/train-key.pem -J ubuntu@$(terraform output jumpbox-pubIP)\"'   ">>  "${WORKSPACE}"/inventory.txt
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
                      sh """
                      cd Terraform/ 
                      terraform destroy -var-file var.tfvars -auto-approve
                      """
                      
                }
                
            }
        }

    }

// else{
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
// }

}



    