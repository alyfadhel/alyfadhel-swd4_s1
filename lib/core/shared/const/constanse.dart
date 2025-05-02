const loginEndPoint = 'login';
const homeEndPoint = 'home';
const categoriesEndPoint = 'categories';
const changeFavoritesEndPoint = 'favorites';
const favoritesEndPoint = 'favorites';
const profileEndPoint = 'profile';
const updateProfileEndPoint = 'update-profile';
String productEndPoint(int id) => 'products/$id';


String? token = '';

late String language;