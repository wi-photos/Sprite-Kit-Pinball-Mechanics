

#import "GameScene.h"
static NSString* ballCategoryName = @"ball";
static NSString* paddleCategoryName = @"paddle";
static NSString* paddle2CategoryName = @"paddle2";

static NSString* blockCategoryName = @"block";
static NSString* GoalCategoryName = @"Goal";
static NSString* Goal2CategoryName = @"Goal2";

static NSString* blockNodeCategoryName = @"blockNode";
static const int Goal3HitCategory = 4;
static const int ballHitCategory = 1;
static const int hiHitCategory = 2;
static const int doomHitCategory = 3;
NSInteger _score;
SKLabelNode* _scoreLabelNode;
SKNode *ball;
SKNode *paddle2;
SKAction *moveNodeUp;
@implementation GameScene
-(void)didMoveToView:(SKView *)view {
    NSError *error;
    self.physicsWorld.contactDelegate = self;
    // SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"bg"];
    //background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    //[self addChild:background];
    self.physicsWorld.gravity = CGVectorMake(-0.0f, -2.0f);
    SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody = borderBody;
    self.physicsBody.friction = -0.0f;
    SKSpriteNode* doom = [SKSpriteNode spriteNodeWithImageNamed:@"doom"];
    doom.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/10);
    doom.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(801, 19)];
    doom.physicsBody.categoryBitMask = doomHitCategory;
    doom.physicsBody.contactTestBitMask = ballHitCategory;
    doom.physicsBody.collisionBitMask =  ballHitCategory;
    doom.physicsBody.dynamic = NO;

    [self addChild:doom];
    SKSpriteNode* Top = [SKSpriteNode spriteNodeWithImageNamed:@"Top"];

    Top.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/1.2);
    Top.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(801, 19)];

    Top.physicsBody.dynamic = NO;
    
    [self addChild:Top];
    SKSpriteNode* ball = [SKSpriteNode spriteNodeWithImageNamed: @"ball"];
    ball.name = ballCategoryName;
    ball.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/1.6);
    [self addChild:ball];

    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:19];
    ball.physicsBody.categoryBitMask = ballHitCategory;
    ball.physicsBody.contactTestBitMask = doomHitCategory;
    ball.physicsBody.collisionBitMask =  doomHitCategory;
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.frame.size.width/2];
    ball.physicsBody.friction = 0.0f;
    ball.physicsBody.restitution = 1.0f;
    ball.physicsBody.linearDamping = 0.0f;
    ball.physicsBody.allowsRotation = NO;
    ball.physicsBody.dynamic = YES;
    [ball.physicsBody applyImpulse:CGVectorMake(10.0f, -10.0f)];
    SKSpriteNode* Barrier = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    Barrier.position = CGPointMake(self.frame.size.width/4, self.frame.size.height/2.8);
    Barrier.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(19, 801)];
    Barrier.physicsBody.categoryBitMask = hiHitCategory;
    Barrier.physicsBody.dynamic = NO;
    [self addChild:Barrier];
    SKSpriteNode* Barrier2 = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    Barrier2.position = CGPointMake(self.frame.size.width/1.4, self.frame.size.height/2.8);
    Barrier2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(19, 801)];
    Barrier2.physicsBody.categoryBitMask = hiHitCategory;
    Barrier2.physicsBody.dynamic = NO;
    [self addChild:Barrier2];
    SKSpriteNode* paddle = [[SKSpriteNode alloc] initWithImageNamed: @"Flipper1"];
     paddle.name = paddleCategoryName;
    paddle.position = CGPointMake(self.frame.size.width/1.83, self.frame.size.height/3.8);
    [self addChild:paddle];
     paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:paddle.frame.size];
    paddle.physicsBody.restitution = 0.1f;
    paddle.physicsBody.friction = 0.4f;
     paddle.physicsBody.dynamic = NO;
    SKAction *rotateReady1 = [SKAction rotateByAngle: 0.7f duration:0];

    [paddle runAction:rotateReady1];

    SKSpriteNode* paddle2 = [[SKSpriteNode alloc] initWithImageNamed: @"Flipper"];
    paddle2.name = paddle2CategoryName;
    paddle2.position = CGPointMake(self.frame.size.width/2.4, self.frame.size.height/3.8);
    
    paddle2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:paddle2.frame.size];
    paddle2.physicsBody.restitution = 0.1f;
    paddle2.physicsBody.friction = 0.0f;
    paddle2.physicsBody.dynamic = NO;
    SKAction *rotateReady = [SKAction rotateByAngle: -0.7f duration:0];
    [paddle2 runAction:rotateReady];

    [self addChild:paddle2];

    SKSpriteNode* Goal1 = [SKSpriteNode spriteNodeWithImageNamed: @"Goal1"];
    Goal1.name = ballCategoryName;
    Goal1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:Goal1.frame.size];
    Goal1.physicsBody.dynamic = NO;
    
    Goal1.position = CGPointMake(self.frame.size.width/2.2, self.frame.size.height/1.40);
    [self addChild:Goal1];
    SKSpriteNode* Goal2 = [SKSpriteNode spriteNodeWithImageNamed: @"Goal1"];
    Goal2.name = ballCategoryName;
    Goal2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:Goal1.frame.size];
    Goal2.physicsBody.dynamic = NO;
    
    Goal2.position = CGPointMake(self.frame.size.width/1.8, self.frame.size.height/1.40);
    [self addChild:Goal2];
    SKSpriteNode* Goal3 = [SKSpriteNode spriteNodeWithImageNamed: @"Goal1"];
    Goal3.name = ballCategoryName;
    Goal3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:Goal1.frame.size];
    Goal3.physicsBody.dynamic = NO;
    Goal3.physicsBody.categoryBitMask = Goal3HitCategory;
    Goal3.physicsBody.contactTestBitMask = ballHitCategory;
    Goal3.physicsBody.collisionBitMask =  ballHitCategory;
    Goal3.position = CGPointMake(self.frame.size.width/1.95, self.frame.size.height/1.25);
    [self addChild:Goal3];
    SKSpriteNode* FlipperMask1 = [SKSpriteNode spriteNodeWithImageNamed: @"FlipperMask"];
    FlipperMask1.name = ballCategoryName;
    FlipperMask1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:FlipperMask1.frame.size];
    FlipperMask1.physicsBody.dynamic = NO;
    FlipperMask1.position = CGPointMake(self.frame.size.width/1.63, self.frame.size.height/3.2);
    [FlipperMask1 runAction:rotateReady1];

    [self addChild:FlipperMask1];
    SKSpriteNode* FlipperMask2 = [SKSpriteNode spriteNodeWithImageNamed: @"FlipperMask"];
    FlipperMask2.name = ballCategoryName;
    FlipperMask2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:FlipperMask2.frame.size];
    FlipperMask2.physicsBody.dynamic = NO;
    FlipperMask2.position = CGPointMake(self.frame.size.width/3.5, self.frame.size.height/2.8);
    [FlipperMask2 runAction:rotateReady];

    [self addChild:FlipperMask2];
    SKSpriteNode* Bumper1 = [SKSpriteNode spriteNodeWithImageNamed: @"Bumper"];
    Bumper1.name = ballCategoryName;
    Bumper1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:Bumper1.frame.size];
    Bumper1.physicsBody.dynamic = NO;
    Bumper1.position = CGPointMake(self.frame.size.width/2.8, self.frame.size.height/2.3);
    SKAction *rotateBumper = [SKAction rotateByAngle: -0.1 duration:0];
    [Bumper1 runAction:rotateBumper];
    [self addChild:Bumper1];
    SKSpriteNode* Bumper2 = [SKSpriteNode spriteNodeWithImageNamed: @"Bumper2"];
    Bumper2.name = ballCategoryName;
    Bumper2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:Bumper1.frame.size];
    Bumper2.physicsBody.dynamic = NO;
    Bumper2.position = CGPointMake(self.frame.size.width/1.6, self.frame.size.height/2.3);
    SKAction *rotateBumper2 = [SKAction rotateByAngle: -0.0 duration:0];
    [Bumper2 runAction:rotateBumper2];
    [self addChild:Bumper2];
    
}
/*
-(id)initWithSize:(CGSize)size {
    [self startNewGame];
    return self;
}

-(void)startNewGame {


}

-(void)mouseDown:(NSEvent *)theEvent {
    [self startNewGame];
}
*/
-(void)keyDown:(NSEvent *)theEvent {
    SKNode *paddle2 = [self childNodeWithName:@"paddle2"];
    SKAction *rotateLeft = [SKAction rotateByAngle: -1.5f duration:0.6];
    SKAction *rotateLeft2 = [SKAction rotateByAngle: 1.5f duration:0.1];

    [paddle2 runAction:rotateLeft];
    [paddle2 runAction:rotateLeft2];
    SKNode *paddle = [self childNodeWithName:@"paddle"];
    SKAction *rotateLeft1 = [SKAction rotateByAngle: 1.5f duration:0.6];
    SKAction *rotateLeft12 = [SKAction rotateByAngle: -1.5f duration:0.1];
    [paddle runAction:rotateLeft1];
    [paddle runAction:rotateLeft12];


}
-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    if(firstBody.categoryBitMask == doomHitCategory || secondBody.categoryBitMask == ballHitCategory)
    {
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = @"Game Over";
        myLabel.fontSize = 100;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        [self addChild:myLabel];
        SKNode *ball = [self childNodeWithName:@"ball"];
        SKAction *Endgame = [SKAction moveByX:0.0 y:100000000.0 duration:0.0];
        [ball runAction: Endgame];

    }
}
- (void)didBeginContact2score:(SKPhysicsContact *)contact {
}

- (void)didBeginContact2:(SKPhysicsContact *)contact {
    SKNode *scorelabel = [self childNodeWithName:@"scorelabel"];
 
    SKPhysicsBody *firstBody, *secondBody;
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    if(firstBody.categoryBitMask == ballHitCategory || secondBody.categoryBitMask == Goal3HitCategory)
            _score++;
        _scoreLabelNode.text = [NSString stringWithFormat:@"000", _score];
        NSLog(@"%d");
        // Add a little visual feedback for the score increment
        [scorelabel runAction:[SKAction sequence:@[[SKAction scaleTo:1.5 duration:0.1], [SKAction scaleTo:1.0 duration:0.1]]]];
 
 }


-(void)update:(CFTimeInterval)currentTime {
}
@end
