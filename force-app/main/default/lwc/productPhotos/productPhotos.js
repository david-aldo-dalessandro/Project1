//David D'Alessandro
//12/26/21
//JS file for holding all the asset info and related product 

import goodProduct from '@salesforce/contentAssetUrl/GoodProductpng';
import aBetterProduct from '@salesforce/contentAssetUrl/ABetterProductpng';
import yourBestProduct from '@salesforce/contentAssetUrl/YourBestProductpng';


const productPhotosList = [
    { name: "Good Product", image: goodProduct },
    { name: "A Better Product", image: aBetterProduct },
    { name: "Your Best Product", image: yourBestProduct }
];


export { productPhotosList as pics};