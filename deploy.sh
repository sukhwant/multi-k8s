docker build -t sukhwantprafulli/multi-client:latest -t sukhwantprafulli/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sukhwantprafulli/multi-server:latest -t sukhwantprafulli/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sukhwantprafulli/multi-worker:latest -t sukhwantprafulli/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push docker
docker push sukhwantprafulli/multi-client:latest
docker push sukhwantprafulli/multi-server:latest
docker push sukhwantprafulli/multi-worker:latest

# Push docker with SHA tag
docker push sukhwantprafulli/multi-client:$SHA
docker push sukhwantprafulli/multi-server:$SHA
docker push sukhwantprafulli/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sukhwantprafulli/multi-server:$SHA
kubectl set image deployments/client-deployment client=sukhwantprafulli/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sukhwantprafulli/multi-worker:$SHA