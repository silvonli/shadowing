//
//  Lesson.m
//  shadowing
//
//  Created by silvon on 12-11-26.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import "Lesson.h"
#import "Sentence.h"
#import "../layoutConstant.h"

@implementation Lesson

@dynamic title;
@dynamic mp3;
@dynamic sentences;

@synthesize notes = _notes;
@synthesize translation = _translation;


- (NSMutableAttributedString*) getAttributedTitle
{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:self.title];
    // font
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)LESSONTITLE_FONT_NAME, LESSONTITLE_FONT_SIZE, NULL);
    [attTitle addAttribute: (NSString *)kCTFontAttributeName
                value: (__bridge id)ctFont
                range: NSMakeRange(0, [attTitle length])];
    CFRelease(ctFont);
    // 对齐
    CTTextAlignment alignment = kCTTextAlignmentCenter;
    CGFloat floatValue = LESSONTITLE_PARAGRAPH_SPACING;
    CGFloat fSpaceBefore = LESSONTITLE_PARAGRAPH_SPACINGBEFORE;
    CTParagraphStyleSetting paraStyles[3] =
    {
        {
            .spec = kCTParagraphStyleSpecifierAlignment,
            .valueSize = sizeof(CTTextAlignment),
            .value = &alignment
        },
        {
            .spec = kCTParagraphStyleSpecifierParagraphSpacing,
            .valueSize = sizeof(CGFloat),
            .value = &floatValue
        },
        {
            .spec = kCTParagraphStyleSpecifierParagraphSpacingBefore,
            .valueSize = sizeof(CGFloat),
            .value = &fSpaceBefore
        },
    };
    CTParagraphStyleRef aStyle = CTParagraphStyleCreate((const CTParagraphStyleSetting*) &paraStyles, 3);
    [attTitle addAttribute: (NSString*)kCTParagraphStyleAttributeName
                value: (__bridge id)aStyle
                range: NSMakeRange(0, [attTitle length])];
    CFRelease(aStyle);
   
    [str appendAttributedString:attTitle];
    return str;
}

- (NSMutableAttributedString *) getAttributedSentences
{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    // 句子内容字体、字号
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)SENTENCE_FONT_NAME, SENTENCE_FONT_SIZE, NULL);
    CGFloat floatValue = SENTENCE_LINE_SPACING;
    CTParagraphStyleSetting paraStyles[1] =
    {
        {
            .spec = kCTParagraphStyleSpecifierLineSpacing,
            .valueSize = sizeof(CGFloat),
            .value = &floatValue
        },
    };
    CTParagraphStyleRef aStyle = CTParagraphStyleCreate((const CTParagraphStyleSetting*) &paraStyles, 1);
    // 按时间排序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"beginTime" ascending:YES];
    NSArray *sortedSens = [self.sentences sortedArrayUsingDescriptors:[NSArray arrayWithObject:timeSort]];
    for (Sentence* sen in sortedSens)
    {
        NSMutableAttributedString *subAttString = [[NSMutableAttributedString alloc] initWithString:sen.textContent];
        
        [subAttString addAttribute: (NSString *)kCTFontAttributeName
                             value: (__bridge id)ctFont
                             range: NSMakeRange(0, [subAttString length])];

        [subAttString addAttribute: (NSString*)kCTParagraphStyleAttributeName
                             value: (__bridge id)aStyle
                             range: NSMakeRange(0, [subAttString length])];
        
        if (sen.bSel)
        {
            [subAttString addAttribute: (NSString*)kCTForegroundColorAttributeName
                                 value: (__bridge id)[UIColor redColor].CGColor
                                 range: NSMakeRange(0, [subAttString length])];
        }
        [str appendAttributedString:subAttString];
    }
    CFRelease(ctFont);
    CFRelease(aStyle);

    return str;
}

-(NSMutableAttributedString *)getAttributedNotes
{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    // 节标题
    NSMutableAttributedString* sec = [self genAttributedSectionTitle: @"课文注释\n"];
    [str appendAttributedString:sec];
   
    // 内容
    NSString *notes = @"1 He has been there for six months. 他在那儿已经住了6个月了。关于动词的现在完成时，可以参看第1册第83至87课。\n2 a great number of, 许多;，用于修饰复数可数名词。\n3 in the centre of, 在;中部。";
   
    NSMutableAttributedString *attNotes = [[NSMutableAttributedString alloc] initWithString:notes];
    CTFontRef notesFont = CTFontCreateWithName((CFStringRef)NOTES_FONT_NAME, NOTES_FONT_SIZE, NULL);
    [attNotes addAttribute: (NSString *)kCTFontAttributeName
                     value: (__bridge id)notesFont
                     range: NSMakeRange(0, [notes length])];
    CFRelease(notesFont);
    
    
    [str appendAttributedString:attNotes];
    return str;
}

- (NSMutableAttributedString *) getAttributedTranslation
{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    // 节标题
    NSMutableAttributedString* sec = [self genAttributedSectionTitle: @"参考译文\n"];
    [str appendAttributedString:sec];
    // 内容
    NSString *translation = @"    我刚刚收到弟弟蒂姆的来信，他正在澳大利亚。他在那儿已经住了6个月了。蒂姆是个工程师，正在为一家大公司工作，并且已经去过澳大利亚的不少地方了。他刚买了一辆澳大利亚小汽车，现在去了澳大利亚中部的小镇艾利斯斯普林斯。他不久还将到达尔文去，从那里，他再飞往珀斯。我弟弟以前从未出过国，因此，他觉得这次旅行非常激动人心。。";
    NSMutableAttributedString *attTranslation = [[NSMutableAttributedString alloc] initWithString:translation];
    
 
    CTFontRef cfFont = CTFontCreateWithName((CFStringRef)TRANSLATION_FONT_NAME, TRANSLATION_FONT_SIZE, NULL);
    [attTranslation addAttribute: (NSString *)kCTFontAttributeName
                           value: (__bridge id)cfFont
                           range: NSMakeRange(0, [attTranslation length])];
    CFRelease(cfFont);
    
    [str appendAttributedString:attTranslation];
    return str;
}

- (void) setSelectedSentence: (NSInteger) index
{
    if (index<0 || index>self.sentences.count-1)
    {
        return;
    }
    // 按时间排序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"beginTime" ascending:YES];
    NSArray *sortedSens = [self.sentences sortedArrayUsingDescriptors:[NSArray arrayWithObject:timeSort]];
    
    Sentence* sen = [sortedSens objectAtIndex:index];
    Sentence* senPre = index > 0 ? [sortedSens objectAtIndex:index-1] : nil;
    Sentence* senNext= index < self.sentences.count-1 ? [sortedSens objectAtIndex:index+1] : nil;
    
    if (sen.bSel == YES)
    {
        // 前后句子都已被选中，则全取消
        if (senPre.bSel == YES && senNext.bSel == YES)
        {
            for (Sentence* senTem in sortedSens)
            {
                senTem.bSel = NO;
            }
        }
        
        sen.bSel = NO;
    }
    else
    {
        // 前后句子都没被选中，则先全取消
        if (senPre.bSel == NO && senNext.bSel == NO)
        {
            for (Sentence* senTem in sortedSens)
            {
                senTem.bSel = NO;
            }
        }
        
        sen.bSel = YES;
    }
    self.title = @"sss";

}
- (NSNumber*)getSelectedSentencesBeginTime
{
    // 按时间排序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"beginTime" ascending:YES];
    NSArray *sortedSens = [self.sentences sortedArrayUsingDescriptors:[NSArray arrayWithObject:timeSort]];
    for (Sentence* sen in sortedSens)
    {
        if (sen.bSel)
        {
            return sen.beginTime;
        }
    }
    return [[sortedSens objectAtIndex:0] valueForKey:@"beginTime"];
}
- (NSNumber*)getSelectedSentencesEndTime
{
    // 按结束时间降序排序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"endTime" ascending:NO];
    NSArray *sortedSens = [self.sentences sortedArrayUsingDescriptors:[NSArray arrayWithObject:timeSort]];
    for (Sentence* sen in sortedSens)
    {
        if (sen.bSel)
        {
            return sen.endTime;
        }
    }
    return [[sortedSens objectAtIndex:0] valueForKey:@"endTime"];
}

- (NSArray*)getSelectedSentences
{
    NSMutableArray * arrRet = [[NSMutableArray alloc] init];
    // 按时间排序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"beginTime" ascending:YES];
    NSArray *sortedSens = [self.sentences sortedArrayUsingDescriptors:[NSArray arrayWithObject:timeSort]];
    for (int i=1; i<=sortedSens.count; i++)
    {
        Sentence* sen = [sortedSens objectAtIndex:i];
        if (sen.bSel)
        {
            [arrRet addObject:[NSNumber numberWithInt:i]];
        }
    }
    return arrRet;
}

- (NSMutableAttributedString *) getAttributedString
{
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:[self getAttributedTitle]];
    [attString appendAttributedString:[self getAttributedSentences]];
    [attString appendAttributedString:[self getAttributedNotes]];
    [attString appendAttributedString:[self getAttributedTranslation]];
    return attString;
}

- (NSMutableAttributedString *) genAttributedSectionTitle:(NSString *) sec
{
    NSMutableAttributedString* attSec = [[NSMutableAttributedString alloc] initWithString:sec];
    CTFontRef secFont = CTFontCreateWithName((CFStringRef)SECTITLE_FONT_NAME, SECTITLE_FONT_SIZE, NULL);
    [attSec addAttribute: (NSString *)kCTFontAttributeName
                value: (__bridge id)secFont
                range: NSMakeRange(0, [attSec length])];
    CFRelease(secFont);
    CGFloat floatValue = SECTITLE_PARAGRAPH_SPACING;
    CGFloat fSpaceBefore = SECTITLE_PARAGRAPH_SPACINGBEFORE;
    CTParagraphStyleSetting paraStyles[2] =
    {
        {
            .spec = kCTParagraphStyleSpecifierParagraphSpacing,
            .valueSize = sizeof(CGFloat),
            .value = &floatValue
        },
        {
            .spec = kCTParagraphStyleSpecifierParagraphSpacingBefore,
            .valueSize = sizeof(CGFloat),
            .value = &fSpaceBefore
        },
    };
    CTParagraphStyleRef aStyle = CTParagraphStyleCreate((const CTParagraphStyleSetting*) &paraStyles, 2);
    [attSec addAttribute: (NSString*)kCTParagraphStyleAttributeName
                value: (__bridge id)aStyle
                range: NSMakeRange(0, [attSec length])];
    CFRelease(aStyle);
    return attSec;
}
@end
