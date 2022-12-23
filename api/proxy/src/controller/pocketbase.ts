import PocketBase from 'pocketbase';
const client = new PocketBase('http://0.0.0.0:8090');

const g = global as any;
g.EventSource = require('eventsource');

export type HomeCollectionOption =
  | 'trending_movies'
  | 'now_playing_movies'
  | 'upcoming_movies'
  | 'top_rated_movies'
  | 'trending_series'
  | 'top_rated_series';

export type HomeCollectionType = {
  adult: boolean;
  backdrop_path: string;
  id: number;
  title: string;
  original_language: string;
  original_title: string;
  overview: string;
  poster_path: string;
  media_type: string;
  genre_ids: number[];
  popularity: number;
  release_date: string;
  video: boolean;
  vote_average: number;
  vote_count: number;
};

export const cloneHomeData = async (type: HomeCollectionOption, data: HomeCollectionType[]) => {
  const createdRecord = await client.collection(type).create<HomeCollectionType>(data[0]);
  console.log(createdRecord, 'createdRecord');
};
