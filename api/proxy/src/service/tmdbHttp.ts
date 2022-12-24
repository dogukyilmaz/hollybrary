import axios from 'axios';

const tmdbHttp = axios.create({
  baseURL: process.env.TMDB_BASE_URL,
  headers: { 'Content-Type': 'application/json' },
  // timeout: 15000,
});

tmdbHttp.interceptors.request.use((config) => {
  console.log(config.baseURL, 'config.baseURL');
  return config;
});

// tmdbHttp.interceptors.response.use((response) => {
//   return response;
// });

export default tmdbHttp;
