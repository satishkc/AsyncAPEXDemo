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
import getAccountList from '@salesforce/apex/AccountController.getAccountList';
  
export default class WireApex extends LightningElement {
  accounts;
  error;
    
  @wire(getAccountList)
  wiredAccounts({ error, data }) {
    if(data) {
      this.accounts = data;
      this.error = undefined;
    } else if(error) {
      this.error = error;
      this.accounts = undefined;
    }
  }
}