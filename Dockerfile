FROM nginx:alpine

LABEL maintainer="Meghana Sahithi"
LABEL description="Nexvion E-Commerce Static Website"

COPY index.html /usr/share/nginx/html/
COPY products.html /usr/share/nginx/html/
COPY payment.html /usr/share/nginx/html/

COPY style.css /usr/share/nginx/html/
COPY products.css /usr/share/nginx/html/
COPY payment.css /usr/share/nginx/html/

COPY script.js /usr/share/nginx/html/
COPY payment.js /usr/share/nginx/html/

COPY logo.png /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
