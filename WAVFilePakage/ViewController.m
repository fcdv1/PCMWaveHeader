//
//  ViewController.m
//  WAVFilePakage
//
//  Created by CIA on 2017/9/6.
//  Copyright © 2017年 CIA. All rights reserved.
//

#import "ViewController.h"
#import "WAVFilePakage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
- (IBAction)testFileButtonPressed:(id)sender {
    NSString *inputFile = [[NSBundle mainBundle] pathForResource:@"pcmNoHeader" ofType:@"wav"];
    NSString *outputPath = [NSString stringWithFormat:@"%@/Documents/pcmWithHeader.wav",NSHomeDirectory()];
    generateFile((char *)inputFile.UTF8String, 0x5622, 2, 16, (char *)outputPath.UTF8String);
    NSData *data1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"originnalWav" ofType:@"wav"]];
    NSData *data2 = [NSData dataWithContentsOfFile:outputPath];
    uint8_t a,b;
    BOOL equal = YES;
    for (int i = 0; i < data1.length; i++) {
        a = ((uint8_t *)data1.bytes)[i];
        b = ((uint8_t *)data2.bytes)[i];
        if (a != b) {
            equal = NO;
            break;
        }
    }
    if (equal) {
         NSLog(@"相等");
    } else {
         NSLog(@"不相等");
    }
}
- (IBAction)testBufferButtonPressed:(id)sender {
    NSString *inputFile = [[NSBundle mainBundle] pathForResource:@"pcmNoHeader" ofType:@"wav"];
    NSData *pcmData = [NSData dataWithContentsOfFile:inputFile];
    
    unsigned char *waveBuffer = NULL;
    int waveBufferLength = 0;
    generateWaveBuffer((unsigned char *)pcmData.bytes,(int)pcmData.length, 0x5622, 2, 16, &waveBuffer, &waveBufferLength);
    NSData *data1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"originnalWav" ofType:@"wav"]];
    uint8_t a,b;
    BOOL equal = YES;
    for (int i = 0; i < data1.length; i++) {
        a = ((uint8_t *)data1.bytes)[i];
        b = waveBuffer[i];
        if (a != b) {
            equal = NO;
            break;
        }
    }
    if (equal) {
        NSLog(@"相等");
    } else {
        NSLog(@"不相等");
    }
    
    for (int i = 0; i < 0x2b; i++) {
        printf("%x ",waveBuffer[i]);
    }
}




@end
