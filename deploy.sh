docker build -t 13kart/multi-client:latest -t 13kart/multi-client:"$SHA" -f ./client/Dockerfile ./client
docker build -t 13kart/multi-server:latest -t 13kart/multi-server:"$SHA" -f ./server/Dockerfile ./server
docker build -t 13kart/multi-worker:latest -t 13kart/multi-worker:"$SHA" -f ./worker/Dockerfile ./worker
docker push 13kart/multi-client:latest
docker push 13kart/multi-client:"$SHA"
docker push 13kart/multi-server:latest
docker push 13kart/multi-server:"$SHA"
docker push 13kart/multi-worker:latest
docker push 13kart/multi-worker:"$SHA"
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=13kart/multi-server:"$SHA"
kubectl set image deployments/client-deployment client=13kart/multi-client:"$SHA"
kubectl set image deployments/worker-deployment worker=13kart/multi-worker:"$SHA"