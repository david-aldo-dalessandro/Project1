//David D'Alessandro
//12/26/21
//Product Carousel JS file

import { LightningElement, wire, track, api} from 'lwc';
import productList from '@salesforce/apex/ProductCarouselController.GetProducts';
import contractList from '@salesforce/apex/ProductCarouselController.GetContracts';
import insertOrder from '@salesforce/apex/ProductCarouselController.InsertOrder';
import createOrderItems from '@salesforce/apex/ProductCarouselController.CreateOrderItems';
import {pics} from 'c/productPhotos'; 

export default class ProductCarousel extends LightningElement {
//variables to be shared 
@api accountid;
@api currentuser;

//variables that are reactive 
@track pData = [];
@track currentContracts = [];
@track picture;
@track products = [];

//lists for arguments
product2Id = [];
pQuantity = [];

//variables for conditional rendering
cart = false;
orderReady = false;
confirm = false;

testProducts = [{Name: 'testName'}];

    //open wire for the product function to listen for changes in the list of products
    //originally designed this way for the dynamic search list, but that will be implemented later
    @wire(productList)
    productFunction({error, data}){
        if(data){
            //loop over the product records returned
            for(let i = 0; i < data.length; i++){
                //loop over the pictures stored for the products
                for(let j = 0; j < pics.length; j++){
                    //check to see if the product has a picture
                    if(data[i].Name === pics[j].name){
                        //if so, assign the array a picture value
                        this.pData.push({name: data[i].Name, description: data[i].Description, id: data[i].Id, picture: pics[j].image});
                    }//end if data.Name
                }//end for j
            }//end for i
        }//end if data
        else if (error){
            console.log("We didn't get them...");
        }//end if error
    }//end productFunction

    //handles the add to cart 
    handleCurrentProduct(event){
        console.log('handleCurrentProduct clicked!');
        //sets index of clicked product to a readable variable
        this.i = event.target.value;
        //immediatley sets the occurence of a product to false
        this.occ = false;
        //checks if this is the first product in the list
        if(this.products.length === 0 ){
            //if so, pushes the product without checking list
            this.products.push({id: this.pData[this.i].id, name: this.pData[this.i].name, description: this.pData[this.i].description, picture: this.pData[this.i].picture, quantity: 1, index: this.i});
            //conditional rendering for the cart of products
            this.cart = true;
        }//end if = 0
        //if more than one product is in the list
        //means a product is in the cart
        else{
            //loop over all the products in the cart
            for(this.j = 0; this.j < this.products.length; this.j++){
                //if the product is in the cart already, then only its quantity is incremented
                if(this.products[this.j].index === this.i){
                    this.products[this.j].quantity++;
                    //occurence variable is true because it already exists in cart
                    this.occ = true;
                }//end if = indices
            }//end for i
            //if it isn't the first item, and its not already in the cart then it gets added
            if(!this.occ){
                this.products.push({id: this.pData[this.i].id, name: this.pData[this.i].name, description: this.pData[this.i].description, picture: this.pData[this.i].picture, quantity: 1, index: this.i});
            }//end if !occ
        }//end else
    }//end handleCurrentProducts

    //shows the contracts curretnly in the database
    handleShowContracts(){
        //conditional rendering for cart
        this.orderReady = true;
        //imperative call to the contract function
        contractList({accountId: this.accountid})
        .then(contracts => { 
            //loops through all the returned contracts and adds them to a list
            for(this.k = 0; this.k < contracts.length; this.k++){
                this.currentContracts.push(contracts[this.k], this.k);
            }//end k
        })
        .catch(error=>{
            console.error(error);
        })
    }//end handleShowContracts

    //actually inserts the order items into the database
    handleOrder(event){
        console.log('hello we are in the order');
        //loops through the products and gets individual lists of the Ids and Quantities
        //this is done in the order they were added to the cart
        for(let i = 0; i < this.products.length; i++){
            this.product2Id.push(this.products[i].id);
            this.pQuantity.push(this.products[i].quantity);
        }//end for i
        //imperative call to put the items into order items 
        insertOrder({accountId: this.accountid, contractId: event.target.value})
        .then(order => { 
            this.confirm=true;
        })
        .catch(error=>{
            console.error(error);
        })
    }//end handleOrder

    //handles the confirmation of order to be placed into database
    handleConfirm(){
        //imperative call that sends over the list of information to construct the order
        createOrderItems({product2Ids : this.product2Id, pQuantity : this.pQuantity, totalItems : this.products.length, accountId: this.accountid,})
        .then(result => { 
            console.log('We entered this order: ');
            this.pData = false;
        })
        .catch(error=>{
            console.error(error);
        })
        
    }//end handlConfirm
}//end class