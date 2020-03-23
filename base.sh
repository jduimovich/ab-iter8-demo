
# ISTIO
kubectl get pods -n istio-system | grep istio > /dev/null
if [ $? -eq 0 ] ; then
    echo  "istio-system  already installed"
else  
    (mkdir -p install.tmp; cd install.tmp ; sh ../install_istio.sh 1.4.3)
fi

kubectl apply \
    -f https://raw.githubusercontent.com/iter8-tools/iter8-analytics/master/install/kubernetes/iter8-analytics.yaml \
    -f https://raw.githubusercontent.com/iter8-tools/iter8-controller/master/install/iter8-controller.yaml 



