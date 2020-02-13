

V1_IMAGE=$(kubectl get deployments -n $NS demoservice-v1 -o yaml | yq r - spec.template.spec.containers[0].image)
V2_IMAGE=$(kubectl get deployments -n $NS demoservice-v2 -o yaml | yq r - spec.template.spec.containers[0].image)


kubectl get destinationrule -n $NS   >/dev/null
if [ $? -eq 0 ] ; then
echo run kubectl  
VERSION=$(kubectl get destinationrule -n $NS -o yaml | yq r - items[0].spec.subsets[0].labels.version)
else 
     echo  "No Service, run the default v1-v2 upgrade" 
     VERSION=v1
fi

echo Running AB Roll Forward 
echo demoservice-v1 is $V1_IMAGE  
echo demoservice-v2 is $V2_IMAGE
echo Active Version is $VERSION 
 
 if [ $VERSION == "v1" ] ; then 
    sh run-experiment.sh demoservice-v1 demoservice-v2
  else   
    sh run-experiment.sh demoservice-v2 demoservice-v1
  fi
 
