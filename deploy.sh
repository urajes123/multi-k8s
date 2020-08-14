docker build -t urajes123/multi-client:latest -t urajes123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t urajes123/multi-server:latest -t urajes123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t urajes123/multi-worker:latest -t urajes123/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push urajes123/multi-client:latest
docker push urajes123/multi-server:latest
docker push urajes123/multi-worker:latest

docker push urajes123/multi-client:$SHA
docker push urajes123/multi-server:$SHA
docker push urajes123/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=urajes123/multi-server:$SHA
kubectl set image deployments/client-deployment client=urajes123/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=urajes123/multi-worker:$SHA
