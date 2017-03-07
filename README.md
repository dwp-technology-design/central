# central

# Deployment Host Requirements

Things that need to be configured to 'make deploy'.

1. Install terraform & ensure binary is in path
2. Ensure AWS keys are set in environment variables (for terraform & aws client use)
3. Ensure date and time are correct on the host (AWS connection requirement).
4. Install python-pip and use pip to install the AWS client. 
5. Create a key-pair called id_rsa_central in ~/.ssh
6. eval `ssh-agent` & ssh-add the ~/.ssh/id_rsa_central key

# Deployment 

Run make deploy.

