/**
 * @description       : 
 * @author            : Satish Chandrashekar
 * @group             : 
 * @last modified on  : 03-09-2021
 * @last modified by  : Satish Chandrashekar
 * Modifications Log 
 * Ver   Date         Author                 Modification
 * 1.0   03-09-2021   Satish Chandrashekar   Initial Version
**/
import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
  
export default class WireCPR extends LightningElement {
  @wire(CurrentPageReference) pageRef;
    
  get currentPageRef() {
    return this.pageRef ? JSON.stringify(this.pageRef, null, 2) : '';
  }
}