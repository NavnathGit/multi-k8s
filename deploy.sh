docker build -t navanthd/multi-client-k8s:latest -t navanthd/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t navanthd/multi-server-k8s-pgfix:latest -t navanthd/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t navanthd/multi-worker-k8s:latest -t navanthd/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push navanthd/multi-client-k8s:latest
docker push navanthd/multi-server-k8s-pgfix:latest
docker push navanthd/multi-worker-k8s:latest

docker push navanthd/multi-client-k8s:$SHA
docker push navanthd/multi-server-k8s-pgfix:$SHA
docker push navanthd/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=navanthd/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=navanthd/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=navanthd/multi-worker-k8s:$SHA