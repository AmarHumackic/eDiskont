import axios from 'axios';

const instance = axios.create({
    baseURL: 'http://localhost:55781/api/',
    
});
    // baseURL: 'https://react-diskont.firebaseio.com/'

export default instance;