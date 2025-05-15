# digital-ocean-cloud-templates

This repo contains terraform templates for working with Digital Ocean. 


### Setting terraform variable for Digital Ocean API Key

For ease of use you can simply utilize an environment variables for working with DO.


```bash
export TF_VAR_do_token=<digital-ocean-api-token>
```

When you utilize the following command

```bash
echo $TF_VAR_dok_token
```

Note: If you are using a Linux OS you can set this in your .bashrc for use in subsequent sessions.


### Droplets

### VPC

### Load Balancer