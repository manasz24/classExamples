public class PolymorphismExampleClass {

    // Utility method for a User
    public static void processUser(User theUser) {
        System.debug('Processed User');
    }
    
    // Utility method for a Group
    public static void processGroup(Group theGroup) {
        System.debug('Processed Group');
    }

    public static void processOwnersOfMerchandise() {
        // Select records based on the Owner polymorphic relationship field
        List<Merchandise__c> merchandiseList = [SELECT TYPEOF Owner WHEN User THEN LastName WHEN Group THEN Email END FROM Merchandise__c];	
        // We now have a list of Merchandise__c records owned by either a User or Group
        for (Merchandise__c merch: merchandiseList) {
            // We can use instanceof to check the polymorphic relationship type
            // Note that we have to assign the polymorphic reference to the appropriate
            // sObject type before passing to a method
            if (merch.Owner instanceof User) {
                User userOwner = merch.Owner;
                processUser(userOwner);
            } else if (merch.Owner instanceof Group) {
                Group groupOwner = merch.Owner;
                processGroup(groupOwner);
            }
        }
    }
}