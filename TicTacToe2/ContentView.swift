import SwiftUI

struct ContentView: View {
    @StateObject var gameState = GameState()
    var body: some View {
        let borderSize = CGFloat(5)
        Text(gameState.turnText())
            .font(.title)
            .bold()
            .padding()
        Spacer()
        Text(String(format: "Crosses: %d", gameState.crossesScore))
            .font(.title)
            .bold()
            .padding()
        ZStack{
            Image("orange")
                .resizable()
                .ignoresSafeArea()
                .shadow(radius: 20.0)
            
            VStack(spacing: borderSize)
            {
                ForEach(0...2,id: \.self)
                {
                    row in
                    HStack(spacing: borderSize)
                    {
                        ForEach(0...2,id: \.self)
                        {
                            column in
                            let cell = gameState.board[row][column]
                            Text(cell.Displaytile())
                                .font(.system(size:60))
                                .foregroundColor(Color.black)
                                .bold()
                                .frame(maxWidth:.infinity,maxHeight:.infinity)
                                .aspectRatio(1,contentMode: .fit)
                                .background(Color.white)
                                .onTapGesture {
                                    gameState.placeTile(row, column)
                                }
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0)
                        }
                    }
                }
            }
            
            .background(Color.black)
            .cornerRadius(20.0)
            .shadow(radius: 10.0)
            .padding()
            .alert(isPresented: $gameState.showAlert){
                Alert(
                    title: Text(gameState.alertMessage),
                    dismissButton: .default(Text("Restart"))
                    {
                        gameState.resetBoard()
                    }
                )
            }
        }
            Text(String(format: "Noughts: %d", gameState.noughtsScore))
                .font(.title)
                .bold()
                .padding()
            Spacer()
        }
        
    }
    
    

    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
