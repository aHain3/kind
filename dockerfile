FROM registry.k8s.io/e2e-test-images/agnhost:2.39

# RUN command ["/agnhost", "netexec", "--http-port", ""8080""]
CMD ["/bin/sh", "-c", "'/agnhost netexec --http-port \"8080\"'" ]  
# ENTRYPOINT [ "/agnhost netexec --http-port "8080""]