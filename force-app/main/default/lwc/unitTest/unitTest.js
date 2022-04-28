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
import { LightningElement, api } from 'lwc';
import { sum } from './sum';
  
export default class UnitTest extends LightningElement {
  @api unitNumber = sum(2,3);

  handleChange(event) {
    this.unitNumber = event.target.value;
  }
}