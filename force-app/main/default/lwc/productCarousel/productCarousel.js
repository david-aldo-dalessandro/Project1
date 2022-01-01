import { LightningElement, wire, track, api} from 'lwc';
import productList from '@salesforce/apex/ProductCarouselController.GetProducts';
import contractList from '@salesforce/apex/ProductCarouselController.GetContracts';
import insertOrder from '@salesforce/apex/ProductCarouselController.InsertOrder';
import createOrderItems from '@salesforce/apex/ProductCarouselController.CreateOrderItems';
import {pics} from 'c/productPhotos'; 

export default class ProductCarousel extends LightningElement {

@api accountid;
@api currentuser;

@track pData = [];
@track currentContracts = [];
@track picture;

product2Id = [];
pQuantity = [];


cart = false;
orderReady = false;
confirm = false;

@track products = [];
testProducts = [{Name: 'testName'}];

    @wire(productList)
    productFunction({error, data}){
        if(data){
            console.log(`productCarousel got this data ${data}`);
            console.log('AccountId = ' + this.accountid);
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
        console.log('handleCurrentProduct clicked!' + event.target.value);
        this.i = event.target.value;
        this.occ = false;
        if(this.products.length === 0 ){
            this.products.push({id: this.pData[this.i].id, name: this.pData[this.i].name, description: this.pData[this.i].description, picture: this.pData[this.i].picture, quantity: 1, index: this.i});
            this.cart = true;
        }
        else{
            for(this.j = 0; this.j < this.products.length; this.j++){
                if(this.products[this.j].index === this.i){
                    this.products[this.j].quantity++;
                    this.occ = true;
                }
            }
            if(!this.occ){
                this.products.push({id: this.pData[this.i].id, name: this.pData[this.i].name, description: this.pData[this.i].description, picture: this.pData[this.i].picture, quantity: 1, index: this.i});

            }
        }
        
    }

    handleShowContracts(){
        this.orderReady = true;
        contractList({id: this.accountid})
        .then(contracts => { 
            console.log('We got' + contracts.length + ' contracts: ' + contracts);
            for(this.k = 0; this.k < contracts.length; this.k++){
                this.currentContracts.push(contracts[this.k], this.k);
            }//end k
        })
        .catch(error=>{
            console.error(error);
        })
    }

    
    handleOrder(event){
        console.log('hello we are in the order' + event.target.value);

        for(let i = 0; i < this.products.length; i++){
            this.product2Id.push(this.products[i].id);
            this.pQuantity.push(this.products[i].quantity);
        }
        console.log('Product2 length = ' + this.product2Id.length);
        console.log('pQuantity length = ' + this.pQuantity.length);

        console.log('product2Id being passed in = ' + this.product2Id[0]);

        insertOrder({accountId: this.accountid, contractId: event.target.value})
        .then(order => { 
            this.confirm=true;
        })
        .catch(error=>{
            console.error(error);
        })
       
    }

    handleConfirm(){

        createOrderItems({product2Ids : this.product2Id, pQuantity : this.pQuantity, totalItems : this.products.length, accountId: this.accountid})
        .then(result => { 
            console.log('We entered this order: ' + result);
        })
        .catch(error=>{
            console.error(error);
        })
    }
    
}