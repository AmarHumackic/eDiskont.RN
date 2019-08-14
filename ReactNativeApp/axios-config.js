import axios from 'axios';

const instance = axios.create({
    baseURL: 'http://f0c40490.eu.ngrok.io/api/',
    // baseURL: 'http://localhost:55781/api/',
    
});

export default instance;