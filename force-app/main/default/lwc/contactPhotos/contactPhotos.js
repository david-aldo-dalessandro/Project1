//David D'Alessandro
//12/25/21
//JS file for holding all the asset info and related contact name 

import andyYoungPhoto from '@salesforce/contentAssetUrl/ramielpng';
import arthurSongPhoto from '@salesforce/contentAssetUrl/asset_4png';


const contactPhotosList = [
    { name: "Andy Young", image: andyYoungPhoto },
    { name: "Arthur Song", image: arthurSongPhoto}
];


export { contactPhotosList as pics};