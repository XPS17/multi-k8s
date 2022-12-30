docker build -t xps17/multi-client-k8s:latest -t xps17/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t xps17/multi-server-k8s:latest -t xps17/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t xps17/multi-worker-k8s:latest -t xps17/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push xps17/multi-client-k8s:latest
docker push xps17/multi-server-k8s:latest
docker push xps17/multi-worker-k8s:latest

docker push xps17/multi-client-k8s:$SHA
docker push xps17/multi-server-k8s:$SHA
docker push xps17/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xps17/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=xps17/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=xps17/multi-worker-k8s:$SHA