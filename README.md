# BusinessModellingCA3

<h1>Product Vision</h1>

The deliverable is a working system based on the requirements of the client. These
have been communicated to the Product Owner who has written the outline below
for the purpose of this assessment. The system is based on a set of four
components/EPICS that, when combined, provide operations in a retail outlet. The
type of retail outlet is unspecified, so at every stage it should be possible to
customise the system. For instance, the items that the shop sells, or the sizes of box
that the shop uses. All Components have a high priority (priority = 1). Therefore, it is
up to the group to decide what items they will take into their first Sprint based on the
group capacity and the (potential) dependencies among the items.
A home page must be implemented to allow users to navigate to each of the below
components.


<h2>Component 1: Stock control</h2>
A shop needs to be stocked with items that can be purchased. This component is
used to create different types of items that the shop stocks. It is also used to
increment the number of each item that it has in stock. Items may have expiration
dates that are set when they are created, so this system will remove expired items
from stock when requested to do so.
      • In this component a user is presented with an items main home screen with
      options/buttons to allow users to: “add items” and “view all items”.
      • The “add items” screen will take the following input: item name, item type
      (dropdown with the following options: luxury, essential, gift) and expiration
      date. All fields are mandatory. An add button will add the item to a list. When
      an item is added it gets a unique id and the number of items (quantity) of this
      item type are incremented. A return button/option (if no GUI) will bring the user
      back to the items main home screen.
      • The “view items” screen will display all items in stock in a drop-down list or list
      (if no GUI) with the expiration date of each item. An item can be selected, and
      a delete button can be clicked to remove the item from the dropdown list. A
      return button/option will bring the user back to the items home screen.

<h2>Component 2: Shopping basket and calculations</h2>
A shopper adds items to their shopping basket. This component will sum the values of
the items in the basket and calculate the tax on those items (different items may be
charged tax at different VAT rates).
      • In this component a customer can select from a drop down/option the type of
      items they wish to buy i.e., Luxury, Essential and Gift.
      • Luxury items are €50, Essential are €30 and Gift are €20.
      • When they select an item, a VAT label field automatically displays the VAT
      rate for that item. VAT rates are as follows:
      o Luxury @20%
      o Essential @10%
      o Gift@ 5%
      • The customer inputs the quantity of the type of item selected.
      • A “calculate” button/option will calculate the total cost for that number of items
      applying the appropriate VAT rate.
      • An “Add to Basket” button/option will add the item and quantity of item to the
      basket and clear down all items to allow the customer to add another item.
      • A read-only text area/display option will display the current items and
      quantity of items in the customer’s basket along with the total cost of the
      basket.
      
<h2>Component 3: Correct change calculator</h2>
This component takes the shopping basket total and the amount paid by the
customer and calculates the minimum number of each note and coins to give the
correct change.
      • In this component a user can enter a total value of a shopping basket and the
      amount taken for payment.
      • A calculate button/option will calculate the minimum number of each euronotes
      and coins (fifty, twenty, ten, five and one cents) to give the correct change.
      • A clear button/option clears all the controls.

<h2>Component 4: Item packing</h2>
Each item has different dimensions and weight. Each box has a set of dimensions
and a maximum weight that it can contain. This component calculates the best way
to pack items in boxes such that the number of boxes is minimised without the items
being too heavy for their boxes.
      Ask the user for:
      • The weight and dimensions (i.e., widthxheigthxdepth) of the boxes.
      • The number of items.
      • For each item, get the weight and dimensions of each of the items to be
      packed.
      • Inform the user the number of boxes that they will need to pack these items
