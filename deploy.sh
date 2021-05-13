docker build -t kabulgrover/multi-client-k8s:latest -t kabulgrover/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t kabulgrover/multi-server-k8s:latest -t kabulgrover/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t kabulgrover/multi-worker-k8s:latest -t kabulgrover/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push kabulgrover/multi-client-k8s:latest
docker push kabulgrover/multi-server-k8s:latest
docker push kabulgrover/multi-worker-k8s:latest

docker push kabulgrover/multi-client-k8s:$SHA
docker push kabulgrover/multi-server-k8s:$SHA
docker push kabulgrover/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kabulgrover/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=kabulgrover/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=kabulgrover/multi-worker-k8s:$SHA