//David D'Alessandro
//1/2/22
//JEST test for the product carousel page

import {createElement} from 'lwc'
import ProductCarousel from 'c/productCarousel'
import GetProducts from '@salesforce/apex/ProductCarouselController.GetProducts'
import GetContracts from '@salesforce/apex/ProductCarouselController.GetContracts'
import InsertOrder from '@salesforce/apex/ProductCarouselController.InsertOrder'
import CreateOrderItems from '@salesforce/apex/ProductCarouselController.CreateOrderItems'
import {setImmediate} from "timers"

//create some mock functions
jest.mock( '@salesforce/apex/ProductCarouselController.GetProducts',
()=> ({
    default: jest.fn()
}),
{virtual: true}
)

jest.mock( '@salesforce/apex/ProductCarouselController.GetContracts',
()=> ({
    default: jest.fn()
}),
{virtual: true}
)

jest.mock( '@salesforce/apex/ProductCarouselController.InsertOrder',
()=> ({
    default: jest.fn()
}),
{virtual: true}
)

jest.mock( '@salesforce/apex/ProductCarouselController.CreateOrderItems',
()=> ({
    default: jest.fn()
}),
{virtual: true}
)

//begin testing description
describe('c-product-carousel suite',()=>{

    //before events to load the virtual dom with HTML and JS pages
    beforeEach(()=>{
        const element = createElement('c-product-carousel', {
            is: ProductCarousel
        })
        document.body.appendChild(element);
    })

    //after events to clean up
    afterEach(()=> {
        while (document.body.firstChild){
            document.body.removeChild(document.body.firstChild);
        }
    })



})