using System;
using System.Collections.Generic;
					
public class Program
{
	public static void Main()
	{
		new CheckoutFixture().PerformUnitTest();
	}
}

public class Offer
{
	public int Discount { get; set; }
	public int NumberOfItems { get; set; }
}

public interface ICheckout
{
	void Scan(char item);
	int Total{get;}
}

public class Checkout : ICheckout
	{
        private Dictionary<char, int> _prices;
        private Dictionary<char, Offer> _offers;
        private Dictionary<char, int> _itemCounters;

        public Checkout()
        {
            _itemCounters = new Dictionary<char, int> { { 'A', 0 }, { 'B', 0 }, { 'C', 0 }, { 'D', 0 } };
            _prices = new Dictionary<char, int> { { 'A', 50 }, { 'B', 30 }, { 'C', 20 }, { 'D', 15 } };
            _offers = new Dictionary<char, Offer>
            { 
                {'A', new Offer { Discount = 20, NumberOfItems = 3}},
                {'B', new Offer { Discount = 15, NumberOfItems = 2}},
            };
        }
        public int Total { get; private set; }

        public void Scan(char item)
        {
            _itemCounters[item]++;
            Total += _prices[item];
            if (HasOffer(item) && RequiredNumber(item))
            {
                Total -= _offers[item].Discount;
            }
        }

        private bool HasOffer(char item)
        {
            return _offers.ContainsKey(item);
        }

        private bool RequiredNumber(char item)
        {
            return _itemCounters[item] == _offers[item].NumberOfItems;
        }
    }

// This is the unit test section. Please don't change. 
public class CheckoutFixture
{
	
	public void PerformUnitTest()
	{
		ScanMultipleItems("", 0, "Test Checkout Zero");
		ScanMultipleItems("A", 50, "Test Checkout Single A");
		ScanMultipleItems("B", 30, "Test Checkout Single B");
		ScanMultipleItems("C", 20, "Test Checkout Single C");
		ScanMultipleItems("D", 15, "Test Checkout Single D");
		
		ScanMultipleItems("AA", 100, "Test Checkout Multiple AA");
		ScanMultipleItems("AB", 80, "Test Checkout Multiple AB");
		ScanMultipleItems("ABC", 100, "Test Checkout Multiple ABC");
		ScanMultipleItems("ABCD", 115, "Test Checkout Multiple ABCD");
		
		// Additional tests for special prices (A: 3 for 130, B: 2 for 45)
		ScanMultipleItems("AAA", 130, "Test Checkout Multiple AA");
		ScanMultipleItems("BB", 45, "Test Checkout Multiple AB");
		ScanMultipleItems("AAABB", 175, "Test Checkout Multiple ABC");
		
	}
	
	private void ScanMultipleItems(string items, int total, string testId)
	{
		// Arrange
		var checkout = new Checkout();

		// Act
		for (int i = 0; i < items.Length; i++)
		{
			checkout.Scan(items[i]);
		}

		// Assert
		Console.WriteLine(total == checkout.Total ? testId + ": PASS" : testId + "FAIL");
	}
} 
