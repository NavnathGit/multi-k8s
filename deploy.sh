docker build -t navanthd/multi-client:latest -t navanthd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t navanthd/multi-server:latest -t navanthd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t navanthd/multi-worker:latest -t navanthd/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push navanthd/multi-client:latest
docker push navanthd/multi-server:latest
docker push navanthd/multi-worker:latest
docker push navanthd/multi-client:$SHA
docker push navanthd/multi-server:$SHA
docker push navanthd/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=navanthd/multi-server:$SHA
kubectl set image deployments/client-deployment client=navanthd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=navanthd/multi-worker:$SHA