# Required to make ECS agent work on systems in SELinux enforcing mode
echo "ECS_AGENT_PID_NAMESPACE_HOST=true" > /etc/ecs/ecs.config
