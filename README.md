# **Node Base Image with Auto-Update Capability**

This Docker image is designed for rapid prototyping and running Node.js applications directly from a private GitHub repository. It includes built-in functionality for:

- Automatically pulling the latest changes from the specified repository.
- Restarting the application when new commits are detected.
- Monitoring the application process and restarting it if it crashes.

---

## **Features**
- **Automatic Repository Updates**: Checks for new commits at regular intervals and updates the local repository when changes are detected.
- **Application Process Monitoring**: Ensures the application remains running, restarting it automatically if it crashes.
- **Configurable Settings**: Adjust polling intervals, debugging, and other options via environment variables.
- **Dynamic Dependency Installation**: Installs `npm` dependencies automatically if `package.json` is detected in the repository.

---

## **Usage**

### **1. Pull the Image**
```bash
docker pull tylerstraub/node-base-image:latest
```

### **2. Run the Container**
```bash
docker run -it --rm \
    -e GITHUB_TOKEN=<your_personal_access_token> \
    -e REPO_URL=https://github.com/<your_username>/<your_repo>.git \
    -e START_SCRIPT="node index.js" \
    -e UPDATE_INTERVAL=60 \
    tylerstraub/node-base-image:latest
```

---

## **Environment Variables**

| **Variable**         | **Required** | **Default** | **Description**                                                                                   |
|-----------------------|--------------|-------------|---------------------------------------------------------------------------------------------------|
| `GITHUB_TOKEN`        | Yes          | None        | A GitHub Personal Access Token for cloning the private repository.                              |
| `REPO_URL`            | Yes          | None        | The HTTPS URL of the GitHub repository to clone.                                                 |
| `START_SCRIPT`        | Yes          | None        | The command to start the Node.js application (e.g., `node index.js`).                            |
| `UPDATE_INTERVAL`     | No           | `60`        | The interval (in seconds) to check for repository updates.                                       |
| `STOP_TIMEOUT`        | No           | `5`         | Time (in seconds) to wait for the application to shut down gracefully before force-killing it.   |
| `DEBUG`               | No           | `false`     | If set to `true`, enables debug logging for more detailed output.                                |

---

## **Dynamic Configuration**

### **Polling Interval**
The polling interval can be updated dynamically by creating or modifying the `/config/update_interval` file inside the container:
```bash
echo "30" > /config/update_interval
```

---

## **Key Features**

### **Automatic Updates**
The container continuously monitors the specified GitHub repository. When a new commit is detected, it:
1. Pulls the latest changes.
2. Restarts the Node.js application.

### **Process Monitoring**
If the Node.js application process crashes or exits, the container will automatically restart it.

### **Debug Mode**
Enable detailed logging by setting `DEBUG=true`. This is useful for troubleshooting during development.

---

## **Example**

### **Basic Run**
```bash
docker run -it --rm \
    -e GITHUB_TOKEN=<your_personal_access_token> \
    -e REPO_URL=https://github.com/tylerstraub/node-test-priv.git \
    -e START_SCRIPT="node index.js" \
    -e UPDATE_INTERVAL=120 \
    tylerstraub/node-base-image:latest
```

### **With Debug Logging**
```bash
docker run -it --rm \
    -e GITHUB_TOKEN=<your_personal_access_token> \
    -e REPO_URL=https://github.com/tylerstraub/node-test-priv.git \
    -e START_SCRIPT="node index.js" \
    -e DEBUG=true \
    tylerstraub/node-base-image:latest
```

---

## **Advanced Features**

### **Customizing the Polling Interval**
The polling interval can be adjusted dynamically by creating a file inside the container:
```bash
docker exec -it <container_id> sh -c "echo '30' > /config/update_interval"
```

### **Inspecting Running Processes**
You can inspect the running processes inside the container:
```bash
docker exec -it <container_id> ps aux
```
