#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
NAMESPACE="observability"
RELEASE_NAME="observability-stack"
CHART_PATH="./charts/observability-stack"

echo -e "${BLUE}🚀 Deploying Observability Stack to Kubernetes${NC}"
echo "=================================================="

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo -e "${RED}❌ kubectl is not installed or not in PATH${NC}"
    exit 1
fi

# Check if helm is available
if ! command -v helm &> /dev/null; then
    echo -e "${RED}❌ Helm is not installed or not in PATH${NC}"
    exit 1
fi

# Check if we can connect to the cluster
echo -e "${YELLOW}🔍 Checking Kubernetes cluster connection...${NC}"
if ! kubectl cluster-info &> /dev/null; then
    echo -e "${RED}❌ Cannot connect to Kubernetes cluster${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Connected to Kubernetes cluster${NC}"

# Create namespace if it doesn't exist
echo -e "${YELLOW}📦 Creating namespace '${NAMESPACE}' if it doesn't exist...${NC}"
kubectl create namespace ${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

# Add required Helm repositories
echo -e "${YELLOW}📚 Adding Helm repositories...${NC}"
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm repo update

echo -e "${GREEN}✅ Helm repositories updated${NC}"

# Update chart dependencies
echo -e "${YELLOW}🔄 Updating chart dependencies...${NC}"
cd ${CHART_PATH}
helm dependency update
cd - > /dev/null

echo -e "${GREEN}✅ Chart dependencies updated${NC}"

# Deploy the observability stack
echo -e "${YELLOW}🚀 Deploying observability stack...${NC}"
helm upgrade --install ${RELEASE_NAME} ${CHART_PATH} \
    --namespace ${NAMESPACE} \
    --create-namespace \
    --wait \
    --timeout 10m

echo -e "${GREEN}✅ Observability stack deployed successfully!${NC}"

# Show deployment status
echo -e "${BLUE}📊 Deployment Status:${NC}"
kubectl get pods -n ${NAMESPACE}

echo ""
echo -e "${BLUE}🎯 Access Information:${NC}"
echo "Grafana will be available at: http://localhost:30300"
echo "Username: admin"
echo "Password: admin123"

echo ""
echo -e "${YELLOW}💡 To access Grafana:${NC}"
echo "kubectl port-forward -n ${NAMESPACE} svc/${RELEASE_NAME}-grafana 3000:80"
echo "Then visit: http://localhost:3000"

echo ""
echo -e "${YELLOW}💡 To check logs:${NC}"
echo "kubectl logs -n ${NAMESPACE} -l app.kubernetes.io/name=grafana"

echo ""
echo -e "${GREEN}🎉 Observability stack is ready!${NC}"
