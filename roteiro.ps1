az aks get-credentials --resource-group TesteKubernetes --name AKSCluster --overwrite-existing

helm repo add kedacore https://kedacore.github.io/charts

helm install keda kedacore/keda --namespace ingress-nginx

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm install ingress-controller ingress-nginx/ingress-nginx --namespace ingress-nginx --set controller.replicaCount=2 --set controller.metrics.enabled=true --set controller.podAnnotations."prometheus\.io/scrape"="true" --set controller.podAnnotations."prometheus\.io/port"="10254"

kubectl apply --kustomize github.com/kubernetes/ingress-nginx/deploy/prometheus/

func kubernetes deploy --name functionappcontagem --image-name CAMINHO_COMPLETO_IMAGEM --namespace ingress-nginx --dry-run > deployment-keda.yml

kubectl apply -f deployment-keda.yml --namespace ingress-nginx

kubectl apply -f ingress-functionappcontagem.yml --namespace ingress-nginx

kubectl apply -f ingress-prometheus.yml --namespace ingress-nginx

kubectl apply -f scaledobject-functionappcontagem.yml --namespace ingress-nginx