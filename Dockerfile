FROM node
COPY ./production/  .
RUN npm install
EXPOSE 3000
CMD ["npm", "start"] 
