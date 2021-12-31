import { LightningElement, wire, track} from 'lwc';
import productList from '@salesforce/apex/ProductCarouselController.GetProducts';
import insertProducts from '@salesforce/apex/ProductCarouselController.InsertProducts';
import {pics} from 'c/productPhotos'; 

export default class ProductCarousel extends LightningElement {

@track pData = [];
@track picture;

cart = false;

@track products = [];
testProducts = [{Name: 'testName'}];

    @wire(productList)
    productFunction({error, data}){
        if(data){
            console.log(`productCarousel got this data ${data}`);
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

    handleCurrentProduct(event){
        console.log('We have been clicked!' + event.target.value);
        this.i = event.target.value;
        this.products.push({Name: this.pData[this.i].name, Description: this.pData[this.i].description });
        this.cart = true;
    }

    handleAddToOrder(){
        console.log('hello we are in the order');
        insertProducts({newProducts: this.products})
        .then(result => { 
            console.log('Success: ' + result);
        })
        .catch(error=>{
            console.error(error);
        })
    }
}