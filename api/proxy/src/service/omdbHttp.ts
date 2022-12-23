import axios from 'axios';

const pbHttp = axios.create({
  baseURL: `${process.env.OMDB_BASE_URL}`,
  headers: { 'Content-Type': 'application/json' },
  // timeout: 15000,
});

// pbHttp.interceptors.request.use((config) => {
//   return config;
// });

// pbHttp.interceptors.response.use((response) => {
//   return response;
// });

export default pbHttp;
