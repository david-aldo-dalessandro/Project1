import { LightningElement, wire, track} from 'lwc';
import productList from '@salesforce/apex/ProductCarouselController.GetProducts';
import {pics} from 'c/productPhotos'; 

export default class ProductCarousel extends LightningElement {

@track pData = [];
@track picture;

    @wire(productList)
    productFunction({error, data}){
        if(data){
            console.log(`producCarousel got this data ${data}`);
            for(let i = 0; i < data.length; i++){
                for(let j = 0; j < pics.length; j++){
                    if(data[i].Name === pics[j].name){
                        this.pData.push({name: data[i].Name, description: data[i].Description, id: data[i].Id, picture: pics[j].image});
                    }//end if data.Name
                }//end for j
            }//end for i
        }//end if data
        else if (error){
            console.log("We didn't get them...");
        }
    }
}