// Function to add an item to the basket
function addItemToBasket(event) {
    event.preventDefault();
  
    const nameOfItem = document.getElementById('nameOfItem').value;
    if (nameOfItem.trim() !== '') {
      const basketList = document.getElementById('basketList');
      const newItem = document.createElement('li');
      newItem.textContent = itemName;
  
      const removeButton = document.createElement('button');
      removeButton.textContent = 'Remove';
      removeButton.onclick = function () {
        removeItemFromBasket(newItem);
      };
  
      newItem.appendChild(removeButton);
      basketList.appendChild(newItem);
      document.getElementById('nameOfItem').value = '';
    }
  }
  
  // Function to remove an item from the basket
  function removeItemFromBasket(item) {
    const basketList = document.getElementById('basketList');
    basketList.removeChild(item);
  }
  
  document.getElementById('addItemForm').addEventListener('submit', addItemToBasket);
  
