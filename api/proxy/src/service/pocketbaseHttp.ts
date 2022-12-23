import axios from 'axios';

const pocketbaseHttp = axios.create({
  baseURL: `${process.env.POCKETBASE_URL}/api`,
  headers: { 'Content-Type': 'application/json' },
  // timeout: 15000,
});

// pocketbaseHttp.interceptors.request.use((config) => {
//   return config;
// });

// pocketbaseHttp.interceptors.response.use((response) => {
//   return response;
// });

export default pocketbaseHttp;
